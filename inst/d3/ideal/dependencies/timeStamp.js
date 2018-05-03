// time-stamp goop
var ft;
var in_formatTime = d3.time.format("%Y-%m-%d %H:%M:%S");
var out_formatTime = d3.time.format("%B %-e, %Y");

d3.csv("../data/timeStamp.csv",
       function(error,data){
	   data.forEach(function(d) {
	       d.mtime = in_formatTime.parse(d.date);
	   });
	   ft = data;
	   // console.log(ft[0].mtime);
       }
      );


// non-unanimous votes
var nvotes;
d3.csv("../data/nvotes.csv",
       function(error,data){
	   data.forEach(function(d) {
		   d.nvotes = +d.nvotes;
	       });
	   nvotes = data;
       }
       );
