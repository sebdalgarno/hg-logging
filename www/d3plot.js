Shiny.addCustomMessageHandler("yearTotalJs",
function(message){
  var data = message;
    var w = 0.4 * window.innerWidth;
    var h = 0.9 * window.innerHeight;
    var barPadding = 0;

  var svg = d3.select("body")
            .append("svg")  
            .style("width", w + 'px')   // <-- Here
            .style("height", h + 'px');
  
   
  var bars = svg.selectAll("rect")
    .data(data)  // <-- The answer is here!
    .enter()
    .append("rect")
   .attr("x", function(d, i) {
    return i * (w/data.length);})
   .attr("width", w / data.length - barPadding)
   .attr("y", function(d){
      return h - d.Total;
   })
   .attr("height", function(d){
     return d.Total;
   })
   .attr("fill", function(d){
     return d.Colour;
   });
   
 svg.selectAll("text")
   .data(data)
   .enter()
   .append("text")
   .text(function(d){
     return d.Total;
   })
   .attr("x", function(d, i){
     return i * (w/data.length);
   })
   .attr("y", function(d){
     return h - d.Total/ + 15;
   })
   .attr("text-anchor", "middle")
   .attr("fill", "white")


})

