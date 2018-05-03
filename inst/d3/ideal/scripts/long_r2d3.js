
var margin = {top: 60, right: 10, bottom: 60, left: 10},
    width = width - margin.left - margin.right,
    height = height - margin.top - margin.bottom;

var dataset;

// define svg object
var svg = d3.select("body")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// poke data at it
r2d3.onRender(function(root, svg, width, height, options, error){
       if(error) {
           console.log(error);
       } 
       
       data.forEach(function(d) {
           d.indx = +d.indx;
           d.idealPoint = +d.idealPoint;
           d.lo = +d.lo;
           d.up = +d.up;
       });
       
       dataset = data;
       colorValue = function(d) {
           return d.party; },
       color = d3.scale.ordinal()
           .domain(["R","D","I"])
           .range(["red","blue","green"]);
       
       var xmin = d3.min(dataset, function(d) { return +d.lo; });
       var xmax = d3.max(dataset, function(d) { return +d.up; });
       var xrange = xmax-xmin;

       var ymin = d3.min(dataset, function(d) { return +d.indx; });
       var ymax = d3.max(dataset, function(d) { return +d.indx; });
       var yrange = ymax - ymin;
       var yup = ymax + (.0025 * yrange);
       var ylo = ymin - (.0025 * yrange);

       var xScale = d3.scale.linear()
           .range([0, width])
           .domain([xmin - .01*xrange, xmax + .01*xrange]);

       var yScale = d3.scale.linear()
           .range([height, 0])
           .domain([ylo, yup]);

       var xTickValues = d3.range(-2,2,1);
       
       // axes grids
       function make_x_grid(){
           return d3.svg.axis()
           .scale(xScale)
           .orient("bottom")
       }

       svg.append("g")         
                .attr("class", "grid")
                .style("opacity",0.15)
                .call(make_x_grid()
                 .tickSize(height, 0, 0)
                 .tickFormat("")
                 );
       
       // plot data
       svg.selectAll("rect")
           .data(dataset)
           .enter()
           .append("svg:rect")
           .attr("x",function(d){
           //console.log(d.lastnm,d.idealPoint);
           return xScale(d.idealPoint) - 1.5;
           })
           .attr("y",function(d){
           return yScale(d.indx) - 1.5;
           })
               .attr("width",4)
           .attr("height",4)
           .style("opacity",.50)
               .style("fill",function(d) { 
           return color(colorValue(d)); 
           });

       var horizontal = svg.append("g")
            .append("svg:line")
            .style("stroke-width", "1px")
            .style("stroke","#999");

       var highLighted = svg.append("g")
           .append("svg:rect")
           .attr("class","rect")
           .attr("width",11)
           .attr("height",11)
           .attr("x",1)
           .attr("y",1)
           .style("fill","black")
           .style("opacity",0.00);
       
       var confidenceInterval = svg.append("g")
           .attr("class","line")
               .style("opacity",0.00)
           .attr("stroke-width", "4px");

       var info = svg.append("g")
           .attr("transform", "translate(" + (width - -40) + ",0)")
               .style("fill", "#777")
           .style("letter-spacing","-1px")
           .attr("font-size", (width*0.003) + "em");
           //.style("font-size", "14px");

       info.append("text")
           .attr("class","label");        
           
       // info.append("text")
       //    .attr("class","party")
       //    .attr("transform", "translate(0, 34)");

       info.append("text")
           .attr("class","rank")
           .attr("transform", "translate(0, 34)");

       // confidence intervals
       svg.selectAll("confidenceIntervals")
           .data(dataset)
           .enter()
           .append("svg:line")
           .attr("class","line")
           .attr("x1",function(d){
           return xScale(d.lo);
           })
           .attr("x2",function(d){
           return xScale(d.up);
           })
           .attr("y1",function(d){
           return yScale(d.indx);
           })
           .attr("y2",function(d){
           return yScale(d.indx);
           })
           .style("opacity",0.11)
           .style("stroke","lightslategrey")
           .style("stroke-width","4px")
           .on("mouseover",
               function(){
                   d3.select(this).style("opacity",.55);
               }
              )
           .on("mouseout",
               function(){
                   d3.select(this).style("opacity",.11);
               highLighted.style("opacity",0.00);
               }
              )
           .on("mousemove",mymousemove); 
       
       function mymousemove() {
           y0 = yScale.invert(d3.mouse(this)[1]);
           i = d3.round(y0);
               if(i>ymax){
           i = ymax;
           }
           if(i<ymin){
           i = ymin;
           }
           d = dataset[i-1];

           xLoc = xScale(d.idealPoint);
           yCoord = yScale(d.indx);
           highLighted.style("opacity",.85);
           highLighted.attr("x",xLoc-5);
           highLighted.attr("y",yCoord-5); 
           hcol = color(colorValue(d));
           highLighted.style("fill",hcol);

           if(yCoord>(height-100)){
           yCoord2 = height-100;
           } else {
           yCoord2 = yCoord;
           }
           xCoord1 = xScale(d.up) + 6;
           if(d.idealPoint<0.6){
           xCoord2 = xCoord1 + 40;
           xTextLoc = xCoord2 + 6;
           } else{
           xCoord2 = xScale(d.up) -200;
           xTextLoc = xCoord2 - 210;  
           }
           
           info.attr("transform", "translate(" + xTextLoc + "," + (yCoord2+9) + ")"); 
           info.select(".name").text(d.firstnm + " " + d.lastnm);
           info.select(".party").text("(" + d.party + " " + d.state + "-" + d.district + ")");
           info.select(".rank").text("Rank: " + d.indx + " of " + ymax);
           info.select(".label").text(d.label);

           horizontal.attr("x1", xCoord1);
           horizontal.attr("x2", xCoord2);
           horizontal.attr("y1", yCoord);
           horizontal.attr("y2", yCoord2);
       }


       // titling
       // svg.append("text")
       //     .attr("class", "title")
       //     .attr("x", 12)
       //     .attr("y", 31)
       //     .style("fill","#333")
       //     .attr("font-size", 14)
       //     .text("Ideal points, 115th U.S. House of Representatives");
       // svg.append("text")
       //     .attr("class", "title")
       //     .attr("x", 12)
       //     .attr("y", 51)
       //     .style("fill","#333")
       //     .attr("font-size", 14)
       //     .text("Computed by Simon Jackman."); 
      svg.append("text")
           .attr("class", "title")
           .attr("x", 12)
           .attr("y", 61)
           .style("fill","#333")
           .attr("font-size", 14)
           .text("Legislators sorted by estimated ideal point."); 
      svg.append("text")
          .attr("class", "title")
           .attr("x",12)
           .attr("y",71)
           .attr("font-size", 12)
           .style("fill","#444")
          //     .attr("text-anchor","start")
           .text("Horizontal bars cover 95% credible intervals.");

       svg.append("g")
           .append("svg:a")
           .attr({
           "xlink:href": "https://dx.doi.org/10.1017/S0003055404001194",
           "target": "_blank"})
           .append("svg:text")
           .attr("x",12)
           .attr("y",81)
           .attr("font-size", 10)
           .style("fill","#aaa")
           .on('mouseover', function(d){
               d3.select(this).style("text-decoration","underline");
               d3.select(this).style("fill","blue");
           })
           .on('mouseout', function(d){
               d3.select(this).style("text-decoration","none");
               d3.select(this).style("fill","#aaa");
           })
           .attr("text-anchor","start")
           .text("Methodological details: Clinton, Jackman & Rivers, APSR 2004.");
    
       }
      )
