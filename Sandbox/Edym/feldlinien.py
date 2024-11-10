import numpy as np
import matplotlib.pyplot as plt

# Coulomb-Konstante
k = 8.99e9  

# Funktionen zur Berechnung des elektrischen Felds von einer Punktladung
def E_field(q, r_vec):
    r_mag = np.sqrt(r_vec[0]**2 + r_vec[1]**2)
    if r_mag == 0:
        return np.array([0, 0])
    return k * q / r_mag**2 * (r_vec / r_mag)

# Gesamtfeld aus beiden Ladungen
def total_E_field(Q1, Q2, pos1, pos2, X, Y):
    Ex, Ey = np.zeros(X.shape), np.zeros(X.shape)
    for i in range(X.shape[0]):
        for j in range(X.shape[1]):
            r1 = np.array([X[i, j] - pos1[0], Y[i, j] - pos1[1]])
            r2 = np.array([X[i, j] - pos2[0], Y[i, j] - pos2[1]])
            E1 = E_field(Q1, r1)
            E2 = E_field(Q2, r2)
            Ex[i, j] = E1[0] + E2[0]
            Ey[i, j] = E1[1] + E2[1]
    return Ex, Ey

# Hauptprogramm zur Visualisierung der Feldlinien
def visualize_field(Q1, Q2, pos1, pos2):
    x = np.linspace(-5, 5, 500)
    y = np.linspace(-5, 5, 500)
    X, Y = np.meshgrid(x, y)

    # Berechnung der elektrischen Feldvektoren
    Ex, Ey = total_E_field(Q1, Q2, pos1, pos2, X, Y)

    # Erstellen des Plots
    fig, ax = plt.subplots()
    ax.streamplot(X, Y, Ex, Ey, color=np.sqrt(Ex**2 + Ey**2), cmap='inferno')
    
    # Punktladungen markieren
    ax.plot(pos1[0], pos1[1], 'ro' if Q1 > 0 else 'bo', markersize=5)
    ax.plot(pos2[0], pos2[1], 'ro' if Q2 > 0 else 'bo', markersize=5)

    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('Feldlinien von zwei Punktladungen')
    plt.show()

# Parameter: Ladungen und Positionen
Q1 = 1e-9  # Ladung 1 (in Coulomb)
Q2 = -1e-9  # Ladung 2 (in Coulomb)
pos1 = np.array([0, -2])  # Position von Ladung 1
pos2 = np.array([0, 2])   # Position von Ladung 2

# Feldlinien visualisieren
visualize_field(Q1, Q2, pos1, pos2)

#25LisgJhz18