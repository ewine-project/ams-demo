#include <iostream>
#include <string>

#include <Arguments.h>


int main(int argc, char **argv) {
    {
        ArgumentsCStyle					args(argc, argv);
        std::cout << "program " << args.programName() << " was called with " << args.size() <<
            "commandline arguments ";	
        std::cout << "(space separated arguments of style argument_name:argument value)\n";
        std::string							strs[] = {"-in", "-out", "param1", "param2", ""};
        for (int i=0; ; ++i) {
            if (strs[i] == "") break;
            std::string						var;
            args.setVar(var, strs[i]);
            std::cout << "  " << strs[i] << " = " << var << "\n";
        }
    }
    {
        DashArguments   args(argc, argv);
    }
}
