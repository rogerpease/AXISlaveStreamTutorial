#include "VAXISlaveStreamTutorialIP_SlaveStream.h"
#include "AXISlaveStreamVerification.h"
#include <iostream>
#include <memory> 
#include <sstream> 


class AXISlaveStreamWrapperClass : VAXISlaveStreamTutorialIP_SlaveStream 
{

  public:
    bool debug = true;  
    AXISlaveStreamVerification * SlaveBus; 
  
  AXISlaveStreamWrapperClass () 
  {  
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    VAXISlaveStreamTutorialIP_SlaveStream{contextp.get(), "VAXISlaveStream"};
    
    cout << "Building Master Bus" << endl; 
    SlaveBus = new AXISlaveStreamVerification(); 
    SlaveBus->S_AXIS_TVALID = &this->S_AXIS_TVALID; 
    SlaveBus->S_AXIS_TDATA  = &this->S_AXIS_TDATA; // Master Output
    SlaveBus->S_AXIS_TSTRB  = &this->S_AXIS_TSTRB; // Master Output
    SlaveBus->S_AXIS_TLAST  = &this->S_AXIS_TLAST; 
    SlaveBus->S_AXIS_TREADY = &this->S_AXIS_TREADY; 
    SlaveBus->Initialize();  
  } 

  void ToggleClock() { 
     this->S_AXIS_ACLK = 1; this->eval(); this->S_AXIS_ACLK = 0; this->eval(); 
     if (debug) printf("Clock Toggled\n"); 
    
  } 
  
  void Reset() { this->S_AXIS_ARESETN = 0; ToggleClock(); ToggleClock(); this->S_AXIS_ARESETN = 1; ToggleClock(); } 

  void Run() 
  { 
    this->controlRegister = 0;
    SlaveBus->StreamCompletePackets.push_back({0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07}); 
    for (int i = 0; i < 15; i++) 
    { 
      ToggleClock(); 
      SlaveBus->DriveCycle(); 
    } 
    cout << this->totalRegister << endl;
    assert (this->totalRegister == 28);

    this->controlRegister = 1;
    ToggleClock(); 
    this->controlRegister = 0;
    ToggleClock(); 

    SlaveBus->StreamCompletePackets.push_back({10,20,30,40,50,60,70,80});
    for (int i = 0; i < 15; i++) 
    { 
      SlaveBus->DriveCycle(); 
      ToggleClock(); 
    } 
    cout << this->totalRegister << endl;
    assert (this->totalRegister == 360);
    cout << "PASS" << endl; 

  } 

};


int main(int argc, char **argv) 
{

   cout << "Building " << endl; 
   AXISlaveStreamWrapperClass AXISlaveStreamWrapper; 
   cout << "Resetting " << endl; 
   AXISlaveStreamWrapper.Reset();  
   AXISlaveStreamWrapper.Run();
   std::cout << "Test: ************************************** PASS!!!!  ************************************" <<std::endl;       
   return 0; 

}
