# conversion 3d to 2d test

def conversion(x: float, y: float, z: float) -> list:
    UV_list = []
    u = x/z
    v = y/z

    UV_list.append(u)
    UV_list.append(y)

    return UV_list

def main():
    x = 5.00
    y = 3.00
    z = 12.00

    Converted_list = conversion(x,y,z)
    print('X, Y, Z coordinate converted to U,V: {0:.5f} {1:.5f} '.format(Converted_list[0], Converted_list[1]))


if __name__ == "__main__":
    main()