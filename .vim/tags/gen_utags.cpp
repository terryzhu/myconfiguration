#include "iostream"
#include "string"
#include "vector"
#include "sstream"
#include <fstream>
#include "map"

using namespace std;

int main(int argc, char ** argv) {
    string line;
    std::map < int, string > dat;
    ifstream ifs;
    ifs.open(argv[1]);
    ofstream ofs;
    ofs.open(argv[2]);
    while (std::getline(ifs, line)) {
        string key = line.substr(0, line.find("\t"));
        if (key.find("::") != -1) {
            continue;
        }
				if (key[0] == '!'|| key [0]=='~'){continue;}
				 if (key.find("$") != -1) {continue;}
        int type = line.find(";\"");
        if (type == -1)
            continue;
        type = line[type + 3];
        dat[type] += key + " ";
    }

    int taglist[] = { 'd', 'e', 'f', 'g', 'p', 's', 't', 'u', 'm' };
    for (int i = 0; i < 9; i++) {
        ofs << dat[taglist[i]] << endl;
    }
    ofs.flush();
    ofs.close();

    return 0;
}

