int triangleLength = 200;
float triangleHeight = sqrt(pow(triangleLength,2)-pow(triangleLength/2,2));
float x1 = 100;
float y1 = 250;
float x2 = x1+triangleLength/2;
float y2 = y1-triangleHeight;
float x3 = x1+triangleLength;
float y3 = y1;
float xC = (x1+x2)/2;
float yC = (y1+y2)/2;
int padding = 10;
PFont font;

ArrayList<Student> studentList = new ArrayList<Student>();
ArrayList<Point> pointList = new ArrayList<Point>();

int currentDay = 0;
int yesterdayIndexAfterMod, todayIndexAfterMod;



//Tunable variables
int dailyUnavailableHours = 7; //6h of school + hygiene + commute
int dailyChillingHours = 1; 
int dailyAvailableHours = 24 - dailyChillingHours - dailyUnavailableHours;
int numDays = 200; //num continuous days to simulate

float randomness = 1; //0 - 1. How much students will shift their behaviour
int framesPerInterval = 1;


//Graphs
//Parameters: x-Axis, y-Axis, Graph Type, x1, y1, x2, y2
//Graph types: behaviour over time, scatterplot


//Y-Axis options(must be entered exactly): Grades, Sleep Hours, EC Hours, Study Hours
XYGraph a = new XYGraph("Time", "Sleep Hours", "behaviour over time", 500,50,800,250);

//x, y axis options: Grades, Sleep Hours, EC Hours, Study Hours
XYGraph b = new XYGraph("Sleep Hours", "Grades", "scatterplot", 100,325,300,525);
XYGraph c = new XYGraph("Study Hours", "Grades", "scatterplot", 500,325,800,525);



void setup(){
  size(850,600);
  font = createFont("Cambria",128); 
  textFont(font);
  background(255);
  
  a.drawAxes();
  b.drawAxes();
  c.drawAxes();
}


void draw(){
  //clear background
  noStroke();
  fill(255);
  rect(0,0,450,600);
  rect(450,300,550,330);
  
  stroke(0);
  strokeWeight(2);
  triangle(x1,y1,x2,y2,x3,y3);
  
  textSize(20);
  fill(0);
  text("Extracurriculars",x1-75,y1+25);
  text("Studying",x2-25,y2-25);
  text("Sleep",x3+25,y3+25);
  textSize(15);
  text("Click on the triangle to generate a student",70,20);
  updateDay();
  drawPoints();
  
}

void updateDay(){
  if (frameCount%framesPerInterval==0){
    if (currentDay < 200){
      currentDay += 1;
      yesterdayIndexAfterMod = (currentDay+198)%200; ////(200+(currentDay-2)%200 
      todayIndexAfterMod = (currentDay+199)%200; //(200+(currentDay-1)%200 to avoid problems with negative
      updateStats();
      updateGraphs();
    }
    
    else{
      reset();
    }
  }
}

void drawPoints(){
  for(Point p : pointList){
    p.displayMe();
  }
}


void updateStats(){
  for(Student s : studentList){
    s.myPoint.updateMe();
    s.updateMe();
  }
}

void updateGraphs(){
  a.updateMe();
  b.updateMe();
  c.updateMe();
}


void reset(){
  currentDay = 0;
  for (Student s: studentList){
    s.totalMarks = 0;
    s.totalECHours = 0;
    s.totalSleepHours = 0;
    s.totalStudyHours = 0;
  }
}

void mouseClicked(){
  
  boolean withinTriangle = isInTriangle(mouseX,mouseY);
  
  if(withinTriangle){
    Point p = new Point(mouseX, mouseY);
    pointList.add(p);
    
    Student s = new Student(p, currentDay);//p.percentEC,p.percentStudy,p.percentSleep,p.c,currentDay);
    studentList.add(s);
  }  
  
}

boolean isInTriangle(float x, float y){
  //checks if a point is within a padded triangle
 
 
  //creates vectors from mouse coordinate to each of the triangle's vertices
  PVector v1 = new PVector(x1+padding-x,y1-padding-y);
  PVector v2 = new PVector(x2-x,y2+padding-y);
  PVector v3 = new PVector(x3-padding-x,y3-padding-y);
  
  //sums the angle between adjacent vectors
  float alpha = PVector.angleBetween(v1,v2);
  float beta = PVector.angleBetween(v2,v3);
  float theta = PVector.angleBetween(v3,v1);
  
  //point is within the triangle
  if (int(alpha+beta+theta)==int(2*PI)){
    return true;
  }
  
  return false;
}
