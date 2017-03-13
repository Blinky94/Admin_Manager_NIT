using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace Admin_Manager_NIT
{
      /// <summary>
      /// Method to open a file in parameter
      /// and return the lines content
      /// </summary>
      public static class ReadFileOutPut
      {
            public static List<string> GetLineFromFile(string filename)
            {
                  List<string> _listLine = new List<string>();

                  StreamReader _fileToRead = new StreamReader(@filename);

                  string _line;
                  
                  while ((_line = _fileToRead.ReadLine()) != null)
                  {
                        _listLine.Add(_line);
                  }                
                
                  return _listLine;
            }
      }
}