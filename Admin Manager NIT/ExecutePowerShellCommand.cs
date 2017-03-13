using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.IO;

namespace Admin_Manager_NIT
{
      /// <summary>
      /// Static class to get powerShell script name, and make
      /// the interface between the current script and the command application
      /// </summary>
      public static class ExecutePowerShellCommand
      {
            /// <summary>
            /// Method to load in proper format the powerShell script
            /// </summary>
            /// <param name="filename"></param>
            /// <returns></returns>
            public static string LoadScript(string filename)
            {                
                  try
                  {
                        using (StreamReader sr = new StreamReader(filename))
                        {
                              StringBuilder fileContents = new StringBuilder();

                              string curLine;     

                              while ((curLine = sr.ReadLine()) != null)                              
                                    fileContents.Append(curLine + "\n");                             

                              return fileContents.ToString();
                        }
                  }
                  catch (Exception e)
                  {
                        string errorText = "The file could not be read:";
                        errorText += e.Message + "\n";
                        return errorText;
                  }              
            }

            /// <summary>
            /// Method to run the powerShellScript
            /// </summary>
            /// <param name="scriptText"></param>
            /// <returns></returns>
            public static string RunScript(string scriptText)
            {
                  Runspace runspace = RunspaceFactory.CreateRunspace();

                  runspace.Open();

                  Pipeline pipeline = runspace.CreatePipeline();
                  pipeline.Commands.AddScript(scriptText);

                  pipeline.Commands.Add("Out-String");
                  Collection<PSObject> results = pipeline.Invoke();

                  runspace.Close();

                  StringBuilder stringBuilder = new StringBuilder();

                  foreach (PSObject obj in results)                  
                        stringBuilder.AppendLine(obj.ToString());
                  

                  return stringBuilder.ToString();
            }
      }
}
