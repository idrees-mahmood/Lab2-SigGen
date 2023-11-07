import time

iterations = 0

def mergeSort(x):

    global iterations
    iterations += 1
    n = len(x)
    if n == 1 or n == 0:
        return x
    m = n//2
    L = mergeSort(x[:m])
    R = mergeSort(x[m:])
    out = []
    while L or R:
        if not L:
            out.append(R.pop(0))
        elif not R:
            out.append(L.pop(0))
        elif L[0] < R[0]:
            out.append(L.pop(0))
        else:
            out.append(R.pop(0))
    return out

def main():
    x = [1, 3, 2, 4, 5, 10, 7]
    print(mergeSort(x))
    print(iterations)

if __name__ == '__main__':
    main()