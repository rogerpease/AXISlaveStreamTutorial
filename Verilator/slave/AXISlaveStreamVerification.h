#include <vector> 
#include <iostream> 
#include <sstream>
using namespace std; 

class AXISlaveStreamVerification
{ 

    public :  // Will make private once I'm further down the road. 
        AXISlaveStreamVerification();
        void DriveCycle();
        void Initialize();
        void ReportPipeStatus(ostringstream & ostream);

        bool DEBUG = true;

        // Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted.
        unsigned char * S_AXIS_TVALID; // Slave Input
        // TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
        unsigned int * S_AXIS_TDATA; // Slave Input 
        // TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
        unsigned char * S_AXIS_TSTRB; // Output 

        // TLAST indicates the boundary of a packet.
        unsigned char * S_AXIS_TLAST; // Slave output 
        // TREADY indicates that the slave can accept a transfer in the current cycle.
        unsigned char * S_AXIS_TREADY; // Slave input 
        
        vector<unsigned int>          StreamCurrentPacket;  
        vector<vector<unsigned int>>  StreamCompletePackets;  
	int cycleCount; 
	int tvalidDropPeriod; 

}; 
