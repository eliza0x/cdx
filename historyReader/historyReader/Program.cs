using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization.Json;
using System.IO;

namespace historyReader {
	class Program {
		static void Main(string[] args) {
			JsonReadWrite jrw = new JsonReadWrite(args[0]);
			if (args[1]=="-r") {
				HistoryQueue hq = jrw.Reader();
				Console.WriteLine(hq.TakePath(int.Parse(args[2])));
			}else if(args[1]=="-w") {
				HistoryQueue hq = jrw.Reader();
				hq.EnQ(args[2]);
				jrw.Writer(hq);
				Console.WriteLine("Complete!");
			}
		}
	}
	class JsonReadWrite {
		string history_path = "~/.cdx_history.json";
		public JsonReadWrite(string hi_path) {
			history_path = hi_path;
		}
		public HistoryQueue Reader() {
			StreamReader sr = new StreamReader(@""+history_path);
			string str = "";
			while (sr.Peek()>=0) {
				str+= sr.ReadLine() + Environment.NewLine;
			}
			sr.Close();
			if (str.Length != 0) {
				DataContractJsonSerializer dcjs = new DataContractJsonSerializer(typeof(HistoryQueue));
				byte[] bytes = Encoding.UTF8.GetBytes(str);
				MemoryStream ms = new MemoryStream(bytes);
				HistoryQueue hq = dcjs.ReadObject(ms) as HistoryQueue;
				return hq;
			} else {
				return new HistoryQueue();
			}

		}
		public async void Writer(HistoryQueue hq) {
			DataContractJsonSerializer dcjs = new DataContractJsonSerializer(typeof(HistoryQueue));
			MemoryStream ms = new MemoryStream();
			dcjs.WriteObject(ms, hq);
			string JsonString = Encoding.UTF8.GetString(ms.ToArray());
			StreamWriter sw = new StreamWriter(@"" + history_path);
			await sw.WriteAsync(JsonString);
			sw.Close();
		}
	}
	[System.Runtime.Serialization.DataContract]
	class History {
		[System.Runtime.Serialization.DataMember()]
		public string Path { get; private set; } = "";
		public History(string path) {
			Path = path;
		}
	}
	[System.Runtime.Serialization.DataContract]
	class HistoryQueue {
		[System.Runtime.Serialization.DataMember()]
		public Queue<History> Queue { get; set; } = new Queue<History>();
		public void EnQ(string path) {
			History h = new History(path);
			Queue.Enqueue(h);
			if (Queue.Count>20) {
				Queue.Dequeue();
			}
		}
		public string TakePath(int index) {
			if (index<20) {
				return Queue.ToList()[index].Path;
			}else {
				return "";
			}
		}
	}
}
