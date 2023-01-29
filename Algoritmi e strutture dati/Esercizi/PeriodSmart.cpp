#include <string>
#include <iostream>
using namespace std;

int periodSmart(string s,int size){

    int r[size];
    r[0] = -1;
    int z;

    for(int i=0;i<size-1;i++){
        z = r[i];

        while (z>=0 && (s[z+1] != s[i+1])){
            z = r[z];
        }
        if(s[z+1] == s[i+1]){
            r[i+1] = z+1;
        } else {
            r[i+1] = -1;
        }
        
    
    }

    return size - (r[size-1] +1);
}

int periodNaive (string s) {
    int n = s.length();
    int r;
    string s1, s2;
    for (int p = 1; p <= n; p++) {
        r = n - p;
        s1 = s.substr(0, r);
        s2 = s.substr(p, r);
        if ( s1 == s2 )
            return p;
    }
    return n;
}

int main(){

    string s;
    cout<<"Inserire la stringa"<<endl;
    cin >> s;

    int periodS = periodSmart(s,s.length());
    int periodN = periodNaive(s);
    cout<<"Periodo: "<<period<<endl;
    return 0;
}

