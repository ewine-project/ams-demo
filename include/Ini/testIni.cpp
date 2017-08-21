#include <iostream>
#include <string>
#include <vector>

#include <Ini.h>


int main() {
	Ini::File							ini("test.ini");
	if (ini.empty())
		std::cout << "warning, file does not exsist!\n";

	int									crap;					  
	double								moreCrap;
	std::string							evenMoreCrap;
	int									nonexistingCrap;

	// load variables from ini file (loadVar rturns false if variable is not ound or reading
	// fails from any other reason, like reading int from text)
	ini.loadVar(crap, "crap");
	ini.loadVar(nonexistingCrap, "nonexisting crap");
	ini.loadVar(moreCrap, "more crap");
	ini.loadVar(evenMoreCrap, "even more crap");

	// show what was loaded
	std::cout << "variables in general (nonmarked section):\n" <<
		"  " << "crap = " << crap << "\n" <<
		"  " << "nonexisting crap = " << nonexistingCrap << "\n" <<
		"  " << "more crap = " << moreCrap << "\n" <<
		"  " << "even more crap = " << evenMoreCrap << "\n\n";

	// load variables from "krap" section (sections are marked with [section_name] in ini file)
	int									krapSection = ini.getSectionNumber("krap");
	if (krapSection > 0) {
		// load variable named crap again but from a different section this time -> a different variable
		ini.loadVar(crap, "crap", krapSection);

		// load an array of data
		std::vector<int> array;
		ini.loadArray<int&>([&array](const int& value, int){array.push_back(value);}, "array", std::string(" "), krapSection);

		// show what was loaded
		std::cout << "in krap section:\n" <<
			"  " << "crap = " << crap << "\n" <<
			"  " << "array = ";
		for (int i = 0; i < (int)array.size(); ++i)
            std::cout << array[i] << " ";
		std::cout << std::endl;
	} else {
		std::cout << "crap! krap not found!\n";
	}
	std::cout << "\nPrint of the whole ini file (usefull for debugging):\n";
	ini.print();
}
