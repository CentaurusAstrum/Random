from multiprocessing import Process, Queue
import os

def summation(q, x):
    result = sum(x)  # Nehmen wir an, dass dies Ihre Summationslogik ist
    q.put(result)  # Das Ergebnis in die Queue einfügen

if __name__ == '__main__':
    q = Queue()  # Eine Queue für die Kommunikation zwischen Prozessen erstellen
    x = [1, 2, 3, 4, 5]  # Beispiel-Liste
    p1 = Process(target=summation, args=(q, x,))  # Queue als Argument übergeben
    p1.start()  # Prozess starten
    p1.join()  # Warten, bis der Prozess beendet ist

    result = q.get()  # Ergebnis aus der Queue holen
    print(f"Das Ergebnis ist: {result}")