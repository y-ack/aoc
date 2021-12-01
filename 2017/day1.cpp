// function template
#include <boost/range/adaptors.hpp>
#include <boost/range/numeric.hpp>
#include <boost/range/algorithm.hpp>
#include <boost/range/algorithm_ext.hpp>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace boost::adaptors;
using namespace boost::range;

int part1(std::vector<int> v) {
  v.push_back(v[0]);
  return accumulate(adjacent_filter(v, std::equal_to<int>())
                    .advance_begin(1), 0);
}

int part2(std::vector<int> v) {
  int sum = 0; std::vector<int> u;
  boost::rotate_copy(v, v.begin()+v.size()/2, std::back_inserter(u));
  boost::for_each(v, u,
                  [&sum](int i, int j){if(i==j) sum+=i;});
  return sum;
}

int main () {
  std::ifstream file("input/day1.txt");
  std::string str;
  std::vector<int> v;

  std::getline(file, str);
  str.erase(str.length()-1); //kill newline
  // str = "1221";
  boost::transform(str, std::back_inserter(v),
                   [](char i){return i - '0';});

  std::cout << part1(v) << std::endl;
  std::cout << part2(v) << std::endl;
  return 0;
}
