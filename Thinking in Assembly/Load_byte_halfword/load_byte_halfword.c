
// C datatypes
// char         == 8  bits
// short int    == 16 bits
// long         == 64 bits
// int          == 32 bits



// Verilog CPU Memory
// Data types
// Word     == 32 bits
// Halfword == 16 bits
// Byte     == 8 bits

    //Test all load instuctions
    /*
    int op0 = 13;                   //Word
    unsigned short int op1 = 11;    //Halfword
    unsigned short int op2 = 17;    //Halfword
    char op3 = "E";                 //Byte
    char op4 = "N";                 //Byte
    char op5 = "E";                 //Byte
    char op6 = "S";                 //Byte
    */
    //Test all store instructions   

int void(){


    // Assuming we only have 3 32-bit registers 
    // and plus one just for stack pointer 

    // One possible Algorithm to simulate the function
    // 1- To save s_3 and s_2 into memory
    // 2- Load g,h,i opperands to the registers
    // 3- Add g,h opperands with add instruction
    //      write the result to one of  register[0]
    // 4- Load the j to register[1]
    // 5- Add j,i opperands with add instruction
    //      write the result to register[1]
    // 6- Substract Reg[0] with Reg[1] and write 
    //      to Reg[0]
    // 7- By using load instruction load 
    //      s_3 and s_2 back from memory


    int s_3 = 73;
    int s_1 = 1453;

    int g = 333;
    int h = 444;
    int i = 111;
    int j = 222;

    int result;

    int my_add(int g, int h, int i, int j){
    int f;
    f = (g + h) - (i + j);
    return j;
    }

    result = my_add( g,h,i,j);


    return 0;
}
