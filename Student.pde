class Student{
  
  //fields
  float[] ECHoursThisYear = new float[numDays];
  float[] sleepHoursThisYear = new float[numDays];
  float[] studyHoursThisYear = new float[numDays];
  float[] gradesThisYear = new float[numDays];
  
  float hoursEC,hoursStudy,hoursSleep;
  int totalECHours,totalSleepHours,totalStudyHours,totalMarks;
  float averageEC,averageSleep,averageStudy,averageGrades; 
 
  Point myPoint;
  int initDay;
  
  
  
  //constructor
  Student(Point p, int d){
    this.myPoint = p;
    this.hoursEC = dailyAvailableHours*p.percentEC;
    this.hoursStudy = dailyAvailableHours*p.percentStudy;
    this.hoursSleep = dailyAvailableHours*p.percentSleep;
    this.initDay = d;
  }
  


  //methods
  void updateMe(){
    int daysInitialized = currentDay - this.initDay;
    
    hoursCalculations();
    gradesCalculations();
    
    if(this.gradesThisYear[0]!=0.0){
      this.averageEC = this.totalECHours/currentDay;
      this.averageSleep = this.totalSleepHours/currentDay;
      this.averageStudy = this.totalStudyHours/currentDay;
      this.averageGrades = this.totalMarks/currentDay;
    }
    else{
      this.averageEC = this.totalECHours/daysInitialized;
      this.averageSleep = this.totalSleepHours/daysInitialized;
      this.averageStudy = this.totalStudyHours/daysInitialized;
      this.averageGrades = this.totalMarks/daysInitialized;
    }
  }

  void hoursCalculations(){
    this.hoursEC = dailyAvailableHours*myPoint.percentEC;
    this.hoursSleep = dailyAvailableHours*myPoint.percentSleep;
    this.hoursStudy = dailyAvailableHours*myPoint.percentStudy;
    
    this.totalECHours += this.hoursEC;
    this.totalSleepHours += this.hoursSleep;
    this.totalStudyHours += this.hoursStudy;
    
    this.ECHoursThisYear[todayIndexAfterMod]=this.hoursEC;
    this.sleepHoursThisYear[todayIndexAfterMod]=this.hoursSleep;
    this.studyHoursThisYear[todayIndexAfterMod]=this.hoursStudy;
  }
  
  void gradesCalculations(){
    //sources and function graphs:
    //https://docs.google.com/document/d/15qILg12kAWr6J66dQAfWK3bX-wro7V3mcd4d9lbEOpc/edit?usp=sharing
    
    float a = 30+70/(1+exp(-(this.hoursStudy-3))); //student grade as a function of studying
    float b = 100*exp(-0.05*pow(this.hoursSleep-8,2));//student grade as a function of sleep
    float gradesToday = 0.7*a+0.3*b;
    this.totalMarks+=gradesToday;
    this.gradesThisYear[todayIndexAfterMod]=gradesToday;
  }
}
  
