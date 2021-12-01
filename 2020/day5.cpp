// https://adventofcode.com/2020/day/5
#include <boost/range/irange.hpp>
#include <boost/range/join.hpp>
#include <boost/range/numeric.hpp>
#include <boost/range/algorithm.hpp>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace boost::range;

int main () {
  std::ifstream file("input/day5.txt");
  std::string str;
  std::vector<int> v;
  // the seat encoding is just disguised binary
  auto binary_map = [](char& c){
    if(c=='B' || c=='R') c = '1';
    else if(c=='F' || c=='L') c = '0';
  };

  while (std::getline(file, str)) {
    for_each(str, binary_map);
    v.push_back(std::stoi(str, 0, 2));
  }

  // part 1: max seat
  int max = *max_element(v);
  std::cout << max << std::endl;

  // part 2: missing seat (aka the leetcode missing number trick)
  // re: join: xor is associative and commutative!
  int missing = accumulate(join(v, boost::irange(0, (int)v.size()-1)),
                           0, std::bit_xor<int>()) ^ (max - 1);
  std::cout << missing << std::endl;
  
  return 0;
}
