import math

def calculate_y(x1, x2):
    return (3 * x1**3) * math.cos(x2 - 4)

def main():
    x1_range = range(-6, 6)  # [-6, 5]
    x2_range = range(-6, 5)  # [-6, 4]
    
    print(f"{'x1/x2':<8}|", end="")
    for x2 in x2_range:
        print(f"{x2:^8}|", end="")
    print("\n" + "-" * (9 * len(x2_range) + 6))
    
    for x1 in x1_range:
        print(f"{x1:<8}|", end="")
        for x2 in x2_range:
            y = calculate_y(x1, x2)
            print(f"{y:^8.2f}|", end="")
        print("\n" + "-" * (9 * len(x2_range) + 6))

if __name__ == "__main__":
    main()
