from multiprocessing import Process, Queue, Pool
import numpy as np 
from math import factorial
import time, os

start = 1
end = 1_000_000
x = 1000

def summation(x, q):
    sum = 0
    for i in range(start, end+1):
        sum += i**2
    q.put(sum)
    return sum

def square_root(x):
    sqrt = np.sqrt(x)
    return sqrt

def exp_series(x, N):
    exp = 0.
    for n in range(start, N+1):
        exp += x**n / factorial(n)
    return exp

def log_series(x, N):
    log = 0.
    for n in range(start, N+1):
        log += (-1)**(n+1) / n * (x - 1)**n 
    return log 

def main():

    q = Queue()

    start1 = time.time()

    print('the result of the summation is: ', summation(x, q), '\n')
    print('the result of the squareroot is: ', square_root(x), '\n')
    print('the result of the exp_series is: ', exp_series(x, 100), '\n')
    print('the result of the log_series is: ', log_series(x, 100), '\n')

    end1 = time.time()

    runningtime = (end1 - start1)
    print('Single process time is: ', runningtime, 'seconds', '\n')
    print('_' * 50)

    start2 = time.time()

    p1 = Process(target=summation, args=(x, q))

    p1.start()
    p1.join()
    result = q.get()
    print(result)

    with Pool(processes=4) as pool:
        results = []
        results.append(pool.apply_async(summation, (x, q)))
        results.append(pool.apply_async(square_root, (x,)))
        results.append(pool.apply_async(exp_series, (x, 100,)))
        results.append(pool.apply_async(log_series, (x, 100,)))

        # Ergebnisse sammeln und ausdrucken
        print('Summation:', results[0].get(), '\n')
        print('Square Root:', results[1].get(), '\n')
        print('Exponential Series:', results[2].get(), '\n')
        print('Logarithmic Series:', results[3].get(), '\n')

    end2 = time.time()
    runningtime2 = (end2 - start2)
    print('running time with multiprocessing is: ', runningtime2)

if __name__ == "__main__":
    main()