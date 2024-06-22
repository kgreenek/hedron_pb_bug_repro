#include "example/proto/example.pb.h"

#include <iostream>

int main(int argc, char **argv) {
  example::proto::Example example_pb{};
  example_pb.set_foo(5);
  example_pb.set_bar("bar");
  std::cout << "example_pb.foo: " << example_pb.foo()
            << ", .bar: " << example_pb.bar() << std::endl;
  return 0;
}
