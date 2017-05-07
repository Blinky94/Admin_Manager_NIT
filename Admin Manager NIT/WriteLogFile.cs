using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace Admin_Manager_NIT
{
    public class WriteLogFile
    {
        public static void WriteToLogFile(string _logfileName,string value)
        {
            using (StreamWriter txtWriter = File.AppendText(_logfileName))
            {
                txtWriter.Write("\r\nLog Entry : ");
                txtWriter.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(),
                    DateTime.Now.ToLongDateString());
                txtWriter.WriteLine("  :");
                txtWriter.WriteLine("  :{0}", value);
                txtWriter.WriteLine("-------------------------------");
            }
        }
    }
}