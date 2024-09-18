#include <SDL2/SDL.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <math.h>
#include <stdbool.h>

#define WINDOW_WIDTH 800
#define WINDOW_HEIGHT 600
#define GRID_SIZE 2.0f
#define GRID_STEP 1.0f

// Funktion, die das Vektorfeld definiert
void vector_field(float x, float y, float z, float t, float *vx, float *vy, float *vz) {
    // Beispiel: rotierendes Feld
    *vx = -y;
    *vy = x;
    *vz = sin(t + sqrt(x * x + y * y));
}

// Funktion zum Zeichnen eines Pfeils in 3D
void draw_arrow(float x, float y, float z, float vx, float vy, float vz) {
    glPushMatrix();
    glTranslatef(x, y, z);

    // Vektor normalisieren
    float len = sqrt(vx * vx + vy * vy + vz * vz);
    if (len == 0) {
        glPopMatrix();
        return;
    }
    vx /= len;
    vy /= len;
    vz /= len;

    // Richtung des Vektors bestimmen
    float theta = acos(vz);
    float phi = atan2(vy, vx) * 180 / M_PI;
    theta *= 180 / M_PI;

    glRotatef(phi, 0, 0, 1);
    glRotatef(theta, 0, 1, 0);

    // Pfeil zeichnen
    glBegin(GL_LINES);
    glVertex3f(0, 0, 0);
    glVertex3f(0, 0, len * 0.5f);
    glEnd();

    // Pfeilspitze
    glTranslatef(0, 0, len * 0.5f);
    glutSolidCone(0.05f, 0.1f, 8, 2);

    glPopMatrix();
}

int main(int argc, char *argv[]) {
    SDL_Init(SDL_INIT_VIDEO);

    // SDL Fenster mit OpenGL Kontext erstellen
    SDL_Window *window = SDL_CreateWindow("3D Vektorfeld-Plotter",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        WINDOW_WIDTH, WINDOW_HEIGHT,
        SDL_WINDOW_OPENGL);

    SDL_GLContext gl_context = SDL_GL_CreateContext(window);

    // OpenGL Initialisierung
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);

    // Beleuchtung einstellen
    GLfloat light_pos[] = { 0.0f, 0.0f, 10.0f, 1.0f };
    glLightfv(GL_LIGHT0, GL_POSITION, light_pos);

    bool running = true;
    SDL_Event event;

    float t = 0.0f; // Zeitvariable für die Animation

    // Kamera-Parameter
    float angle = 0.0f;
    float camera_distance = 15.0f;

    while (running) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT)
                running = false;
            else if (event.type == SDL_KEYDOWN) {
                if (event.key.keysym.sym == SDLK_ESCAPE)
                    running = false;
            }
        }

        // Bildschirm löschen
        glClearColor(1, 1, 1, 1);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        // Projektion und Modellansicht einstellen
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        gluPerspective(45.0f, (float)WINDOW_WIDTH / WINDOW_HEIGHT, 1.0f, 100.0f);

        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity();
        gluLookAt(camera_distance * sin(angle), camera_distance * cos(angle), 10.0f,
                  0.0f, 0.0f, 0.0f,
                  0.0f, 0.0f, 1.0f);

        // Achsen zeichnen
        glBegin(GL_LINES);
        // X-Achse
        glColor3f(1, 0, 0);
        glVertex3f(-10, 0, 0);
        glVertex3f(10, 0, 0);
        // Y-Achse
        glColor3f(0, 1, 0);
        glVertex3f(0, -10, 0);
        glVertex3f(0, 10, 0);
        // Z-Achse
        glColor3f(0, 0, 1);
        glVertex3f(0, 0, -10);
        glVertex3f(0, 0, 10);
        glEnd();

        // Vektorfeld zeichnen
        for (float x = -GRID_SIZE; x <= GRID_SIZE; x += GRID_STEP) {
            for (float y = -GRID_SIZE; y <= GRID_SIZE; y += GRID_STEP) {
                for (float z = -GRID_SIZE; z <= GRID_SIZE; z += GRID_STEP) {
                    float vx, vy, vz;
                    vector_field(x, y, z, t, &vx, &vy, &vz);

                    // Farbe basierend auf der Vektorlänge
                    float len = sqrt(vx * vx + vy * vy + vz * vz);
                    glColor3f(len, 0.0f, 1.0f - len);

                    draw_arrow(x, y, z, vx, vy, vz);
                }
            }
        }

        SDL_GL_SwapWindow(window);

        // Zeit aktualisieren
        t += 0.01f;
        angle += 0.002f;

        SDL_Delay(16); // ~60 FPS
    }

    SDL_GL_DeleteContext(gl_context);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
