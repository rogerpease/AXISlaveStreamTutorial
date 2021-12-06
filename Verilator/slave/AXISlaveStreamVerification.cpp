#include <vector> 
#include <iostream> 
#include "AXISlaveStreamVerification.h" 
using namespace std; 


AXISlaveStreamVerification::AXISlaveStreamVerification()
{ 
   cycleCount = 0; 
   tvalidDropPeriod = 0; 
}   

void AXISlaveStreamVerification::Initialize()
{
   *(this->S_AXIS_TVALID) = 0; // Can't do this before because we've not assigned. 
}
   
void AXISlaveStreamVerification::DriveCycle()
{
  
  static bool lastCycleReady   = false; 
  static bool lastCycleHadData = false; 
  bool thisCycleHasData = false; 

  bool lastCycleMovedData = (*(this->S_AXIS_TVALID) && lastCycleReady);

  cout << "Valid " << (*(this->S_AXIS_TVALID) ? '1' : '0')  << endl; 
  cout << "Ready " << (lastCycleReady ? '1' : '0')  << endl; 
   

  // New data should always be in StreamCurrentPacket, even if it's impossible to move. 
  if (StreamCurrentPacket.size() == 0)
  { 
    if (StreamCompletePackets.size() != 0)
    {
      StreamCurrentPacket = StreamCompletePackets[0]; 
      StreamCompletePackets.erase(StreamCompletePackets.begin()); 
    } 
  } 

  // Three options here, assuming we have data to move. 
  //   We had data and moved it.
  //   We had data and didn't move it. 
  //   We didn't have data. 


  // assume we don't have data until proven otherwise. 
  thisCycleHasData = false;

  if (((!lastCycleHadData) || (lastCycleMovedData)) && !StreamCurrentPacket.size()) 
  {
     // We either have nothing to move or moved on our last cycle. 
     *(this->S_AXIS_TDATA) = 0; 
     *(this->S_AXIS_TVALID)  = 0; 
     lastCycleHadData = false; 
     return; 
  } 
  else if ((lastCycleMovedData) || (!lastCycleHadData))  
  {
      // We moved data on last cycle or we didn't have anything to move. 
      if (StreamCurrentPacket.size()) // If we do have it now. 
      {
        *(this->S_AXIS_TDATA) = StreamCurrentPacket[0]; 
        cout << "Pushed " << *(this->S_AXIS_TDATA)  << endl;
        StreamCurrentPacket.erase(StreamCurrentPacket.begin()); 
        thisCycleHasData = true; 
      }
      if (StreamCurrentPacket.size()) 
        *(this->S_AXIS_TLAST)  = 0; 
      else 
        *(this->S_AXIS_TLAST)  = 1; 
   } 

   // If we had data on the last cycle and didn't move it. 
   if ((lastCycleHadData) && (!lastCycleMovedData)) 
   {  
     thisCycleHasData = true;
   } 
   cout << "ThisCycleHasData " << ((thisCycleHasData) ? '1' : '0') << endl;
  
   // Drop TVALID every N tvalidDropPeriod cycles (unless TREADY set to 0).
   *(this->S_AXIS_TVALID) = (!thisCycleHasData) ? 0 : (tvalidDropPeriod == 0) ? 1 : (cycleCount % tvalidDropPeriod == 0) ? 0 : 1; 
   lastCycleHadData  = thisCycleHasData;
   lastCycleReady    = *(this->S_AXIS_TREADY); 
   cycleCount ++; 

}  

void AXISlaveStreamVerification::ReportPipeStatus(ostringstream & ostream)
{
     ostream << "Current: ";
     for (auto a: this->StreamCurrentPacket)
        ostream << hex << a << dec << " ";
     ostream << endl;
     ostream << "Complete: ";
     for (auto a: this->StreamCompletePackets)
     {
       for (auto b: a)
         ostream << hex << b << dec << " ";
       ostream << endl;
     }

}
