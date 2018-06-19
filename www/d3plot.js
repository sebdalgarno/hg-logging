Shiny.addCustomMessageHandler("yearTotalJs",
function(message){

  var data = message;
    var w = 500;
    var h = 500;
    var barPadding = 0;
    var scaleFactor = 10;
    var padding = 40;
    
  
  var xScale = d3.scaleBand()
               .domain(d3.range(data.length))
               .rangeRound([0, w])
               .paddingInner(0.05);
  
    var yScale = d3.scaleLinear()
  .domain([d3.min(data, function(d){
    return d.Total;
  }), d3.max(data, function(d){
    return d.Total;
  })])
  .rangeRound([h - padding, padding]);
    
    var parseTime = d3.timeParse("%Y-%d-%m");
    
    var plot = function(data, svg){
       var rect = svg.selectAll("rect")
    .data(data)  
    .enter()
    .append("rect")
   .attr("x", function(d, i) {
    return xScale(i);
   })
   .attr("width", xScale.bandwidth)
   .attr("y", function(d){
      return yScale(d.Total);
   })
   .attr("height", function(d){
      return (h - yScale(d.Total)) - padding;
   })
   .attr("fill", function(d){
     return d.Colour;
   });
   
   var xAxis = d3.axisBottom()
      .scale(xScale)
      .tickFormat(d3.format("d"));
      
   var yAxis = d3.axisLeft()
      .scale(yScale);
      
   svg.append("g")
          .attr("class", "axis")
          .attr("transform", "translate(0," + (h - padding) + ")")
          .call(xAxis);
          
    svg.append("g")
          .attr("class", "axis")
          .attr("transform", "translate(" + padding + ",0)")
          .call(yAxis);
          
    };
    
    d3.select("svg").remove();
    var svg = d3.select("body")
            .append("svg")  
            .style("width", w + 'px')   // <-- Here
            .style("height", h + 'px');
      plot(data, svg);
 

 



});

   


