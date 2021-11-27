package foo;

import "core:fmt";
import "core:io"

Foo :: struct {
    bar: int,
    foo: ^Foo,
}

Foo_Formatter :: proc(fi: ^fmt.Info, arg: any, verb: rune) -> bool {
    if arg == nil {
        io.write_string(fi.writer, "<nil>");
        return true;
    }

    foo := arg.(^Foo);
    io.write_string(fi.writer, "&Foo{ bar = ");
    fmt.fmt_int(fi, u64(foo.bar), true,  8*size_of(int), verb);
    io.write_string(fi.writer, ", foo = ");
    if foo.foo == nil {
        io.write_string(fi.writer, "<nil>");
    } else {
        fi.indent += 1;
        defer fi.indent -= 1;
        Foo_Formatter(fi, foo.foo, verb);
    }
    io.write_string(fi.writer, " }");
    return true;
}

Foo_formatters := map[typeid]fmt.User_Formatter {
    ^Foo = Foo_Formatter,
};

main :: proc() {
    fmt.set_user_formatters(&Foo_formatters);

    foo := new(Foo);
    foo_foo := new(Foo);

    foo.bar = 42;
    foo.foo = foo_foo;
    foo_foo.bar = 1;

    fmt.printf("Foo: %v\n", foo);
}