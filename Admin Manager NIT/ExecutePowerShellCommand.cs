using System;
using System.Collections.ObjectModel;
using System.IO;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Text;

namespace Admin_Manager_NIT
{
    /// <summary>
    /// Static class to get powerShell script name, and make
    /// the interface between the current script and the command application
    /// </summary>
    public static class ExecutePowerShellCommand
    {
        private static string logFilePowerShell = @"C:\Users\FCazesulfourt\Desktop\Export_CSV_Entretiens_Professionnels\logs\LogPowershell.txt";
        private static string scriptName = string.Empty;

        /// <summary>
        /// Method to load in proper format the powerShell script
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string LoadScript(string _scriptName)
        {
            scriptName = _scriptName;
            try
            {
                using (StreamReader sr = new StreamReader(_scriptName))
                {
                    StringBuilder fileContents = new StringBuilder();

                    string curLine;

                    while ((curLine = sr.ReadLine()) != null)
                        fileContents.Append(curLine + "\n");

                    sr.Close();
                    return fileContents.ToString();
                }
            }
            catch (Exception e)
            {
                string errorText = "The file could not be read:";
                errorText += e.Message + "\n";
                WriteLogFile.WriteToLogFile(logFilePowerShell, errorText);
                return errorText;
            }
        }

        /// <summary>
        /// Method to run the powerShellScript
        /// </summary>
        /// <param name="scriptText"></param>
        /// <returns></returns>
        public static string RunScriptWithNoArgument(string scriptText)
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

        /// <summary>
        /// Method to run the powerShellScript
        /// </summary>
        /// <param name="scriptText"></param>
        /// <returns></returns>
        public static string RunScriptWithArgument(string scriptText,string arg)
        {  
            Runspace runspace = RunspaceFactory.CreateRunspace();

            runspace.Open();

            PowerShell ps = PowerShell.Create();
            ps.AddScript(scriptText).AddArgument(arg);
            Collection<PSObject> results = ps.Invoke();

            runspace.Close();

            StringBuilder stringBuilder = new StringBuilder();

            foreach (PSObject obj in results)
                stringBuilder.AppendLine(obj.ToString());

            return stringBuilder.ToString();
        }
    }
}