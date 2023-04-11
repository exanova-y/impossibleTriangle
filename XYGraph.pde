class XYGraph{
  
  //fields
  String xAxisOption, yAxisOption, type;
  float topLeftX, topLeftY, bottomRightX, bottomRightY;
  float xStep,yStep;
  float lastX,lastY,currentX,currentY;



  //constructor
  XYGraph(String xOpt, String yOpt, String t, int x1, int y1, int x2, int y2){
    this.xAxisOption = xOpt;
    this.yAxisOption = yOpt;
    this.type = t;
    
    this.topLeftX = x1;
    this.topLeftY = y1;
    this.bottomRightX = x2;
    this.bottomRightY = y2;
  }
  
  
  
  //methods
  void drawAxes(){
    strokeWeight(3);
    stroke(0);
    fill(0);
    textSize(10);
    
    if (this.type=="behaviour over time"){
      xAxis("days",numDays,25);
    }
    
    else if (this.type == "scatterplot"){
      if(this.xAxisOption == "EC Hours" ||this.xAxisOption == "Sleep Hours" || this.xAxisOption == "Study Hours" ){
        xAxis("h",dailyAvailableHours,2);
      }
      else if (this.xAxisOption == "Grades"){
        xAxis("%",100,10);
      }
    }
    
    //y Axis for all graphs
    if(this.yAxisOption == "Grades"){
        yAxis("%",100,10);
      }
    else if (this.yAxisOption == "EC Hours" || this.yAxisOption == "Sleep Hours" || this.yAxisOption =="Study Hours" ){
       yAxis("h",16,2);
      }
  }
  
  
  void xAxis(String xUnit, int xMax, int xScale){
    //x axis line
    line(this.topLeftX, this.bottomRightY, this.bottomRightX, this.bottomRightY);
    this.xStep = (this.bottomRightX-this.topLeftX)/xMax;
    
    //label
    text(this.xAxisOption+"("+xUnit+")",((this.topLeftX+this.bottomRightX)/2)-30,this.bottomRightY+30);
    
    //ticks
    for(int i=1;i<=xMax;i++){
      if(i%xScale==0){
        line(this.topLeftX+i*this.xStep,this.bottomRightY-5,this.topLeftX+i*this.xStep,this.bottomRightY+5);
        text(i,this.topLeftX+i*this.xStep-5,this.bottomRightY+15);
      }
    }
  }
  
  
  void yAxis(String yUnit, int yMax, int yScale){
    //y axis line
    line(this.topLeftX, this.topLeftY, this.topLeftX, this.bottomRightY); 
    this.yStep = (this.bottomRightY-this.topLeftY)/yMax;
    
    //label y axis
    textSize(10);
    text(this.yAxisOption+"("+yUnit+")",this.topLeftX-30, this.topLeftY-10);
    
    //ticks
    for(int i=1;i<=yMax;i++){
    if(i%yScale==0){
      line(this.topLeftX-5, this.bottomRightY-i*this.yStep,this.topLeftX+5, this.bottomRightY-i*this.yStep);
      text(i,this.topLeftX-20, this.bottomRightY-i*this.yStep);
     }
    }
  }
  
  
  void updateMe(){
    if (this.type=="behaviour over time"){
      updateLines();
    }
    else if (this.type=="scatterplot"){
      updateDots();
    }
  }
  
  
  void updateLines(){
    strokeWeight(1);
    
    for(Student s: studentList){
      stroke(s.myPoint.c);
      
          if (this.yAxisOption == "Grades"){
            if(s.gradesThisYear[yesterdayIndexAfterMod]!=0 && todayIndexAfterMod != 0){  
              
              this.lastX = this.topLeftX+yesterdayIndexAfterMod*this.xStep;
              this.lastY = this.bottomRightY-this.yStep*s.gradesThisYear[yesterdayIndexAfterMod];
              this.currentX = this.topLeftX+(todayIndexAfterMod*this.xStep);
              this.currentY = this.bottomRightY-this.yStep*s.gradesThisYear[todayIndexAfterMod];
            }
          }
          else if (this.yAxisOption == "EC Hours"){
            if(s.ECHoursThisYear[yesterdayIndexAfterMod]!=0 && todayIndexAfterMod != 0){
              
              this.lastX = this.topLeftX+yesterdayIndexAfterMod*this.xStep;
              this.lastY = this.bottomRightY-this.yStep*s.ECHoursThisYear[yesterdayIndexAfterMod];
              this.currentX = this.topLeftX+(todayIndexAfterMod*this.xStep);
              this.currentY = this.bottomRightY-this.yStep*s.ECHoursThisYear[todayIndexAfterMod];
            }
          }
          else if (this.yAxisOption == "Sleep Hours"){
            if(s.sleepHoursThisYear[yesterdayIndexAfterMod]!=0 && todayIndexAfterMod != 0){
              
              this.lastX = this.topLeftX+yesterdayIndexAfterMod*this.xStep;
              this.lastY = this.bottomRightY-this.yStep*s.sleepHoursThisYear[yesterdayIndexAfterMod];
              this.currentX = this.topLeftX+(todayIndexAfterMod*this.xStep);
              this.currentY = this.bottomRightY-this.yStep*s.sleepHoursThisYear[todayIndexAfterMod];
            }
          }
          else if (this.yAxisOption == "Study Hours"){
            if(s.studyHoursThisYear[yesterdayIndexAfterMod]!=0 && todayIndexAfterMod != 0){
              
              this.lastX = this.topLeftX+yesterdayIndexAfterMod*this.xStep;
              this.lastY = this.bottomRightY-this.yStep*s.studyHoursThisYear[yesterdayIndexAfterMod];
              this.currentX = this.topLeftX+(todayIndexAfterMod*this.xStep);
              this.currentY = this.bottomRightY-this.yStep*s.studyHoursThisYear[todayIndexAfterMod];
            }
          }
          line(this.lastX,this.lastY,this.currentX,this.currentY);
      }
    if(currentDay==200){
      //clear graph
      noStroke();
      fill(255);
      rect(this.topLeftX-50,this.topLeftY-30,this.bottomRightX-this.topLeftX+100, this.bottomRightY-this.topLeftY+70);
      drawAxes();
      }
  }
  
  
  void updateDots(){
    noStroke();
    fill(255);
    rect(this.topLeftX-50,this.topLeftY-20,this.bottomRightX-this.topLeftX+100, this.bottomRightY-this.topLeftY+70);
    drawAxes();
    
    for(Student s: studentList){
      
      //x axis
      if(this.xAxisOption=="EC Hours"){
        this.currentX = this.topLeftX+s.averageEC*this.xStep;
      }
      else if (this.xAxisOption=="Sleep Hours"){
        this.currentX = this.topLeftX+s.averageSleep*this.xStep;
      }
      else if(this.xAxisOption=="Study Hours"){
        this.currentX = this.topLeftX+s.averageStudy*this.xStep;
      }
      else if(this.xAxisOption=="Grades"){
        this.currentX = this.topLeftX+s.averageGrades*this.xStep;
      }
      
      //y axis
      if(this.yAxisOption=="EC Hours"){
        this.currentY = this.bottomRightY-this.yStep*s.averageEC;
      }
      else if(this.yAxisOption=="Sleep Hours"){
        this.currentY = this.bottomRightY-this.yStep*s.averageSleep;        
      }
      else if(this.yAxisOption=="Study Hours"){
        this.currentY = this.bottomRightY-this.yStep*s.averageStudy;
      }
      else if(this.yAxisOption=="Grades"){
        this.currentY = this.bottomRightY-this.yStep*s.averageGrades;
      } 
      strokeWeight(1);
      fill(s.myPoint.c);
      circle(this.currentX,this.currentY,5);
    }
  }
  
 
}
