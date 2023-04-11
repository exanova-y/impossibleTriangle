class Point{
  
  //fields
  float xValue, yValue;
  float vX, vY;
  color c;
  float percentEC,percentStudy,percentSleep;
  
  
  
  //constructor
  Point(float x, float y){
    this.xValue = x;
    this.yValue = y;
    this.c = color(int(random(0,255)),int(random(0,255)),int(random(0,255)));
    
    //percent as decimals
    this.percentEC = (triangleLength-dist(x,y,x1,y1))/triangleLength;
    this.percentStudy = (triangleLength-dist(x,y,x2,y2))/triangleLength;
    this.percentSleep = (triangleLength-dist(x,y,x3,y3))/triangleLength;
  }
 
  
  
  //methods
  void updateMe(){
    if (numDays%50== 0){
      newVelocity();
    }
    //move points
    this.xValue += this.vX;
    this.yValue += this.vY;
    
    //new percents
    this.percentEC = (triangleLength-dist(this.xValue,this.yValue,x1,y1))/triangleLength;
    this.percentStudy = (triangleLength-dist(this.xValue,this.yValue,x2,y2))/triangleLength;
    this.percentSleep = (triangleLength-dist(this.xValue,this.yValue,x3,y3))/triangleLength;
    
    //discourage points from the triangle's edge. Uses a triangle with padding
    boolean inTriangle = isInTriangle(this.xValue,this.yValue);
    if(!inTriangle){
      this.xValue += -6*this.vX;
      this.yValue += -6*this.vY;
    }
    displayMe();
  }
  
  void newVelocity(){
    this.vY = randomness*random(-1,1);
    this.vX = randomness*random(-1,1);
  }
  
  void displayMe(){
    fill(c);
    strokeWeight(1);
    circle(this.xValue,this.yValue,5);
  }
  
  
}
