using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.IO;
using System.Threading;

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
                  PowerShell ps = PowerShell.Create().AddCommand(scriptText);
                 
                  // Create the output buffer for the results.
                  PSDataCollection<PSObject> output = new PSDataCollection<PSObject>();

                  // Create an IAsyncResult object and call the
                  // BeginInvoke method to start running the 
                  // command pipeline asynchronously.
                  IAsyncResult async = ps.BeginInvoke<int, PSObject>(null, output);

                  StringBuilder stringBuilder = new StringBuilder();

                  // Using the PowerShell.EndInvoke method, run the command
                  // pipeline using the default runspace.
                  foreach (PSObject result in output)
                  {
                        stringBuilder.Append(result);
                  } // End foreach.

                  return stringBuilder.ToString();                 
            }
      }
}
