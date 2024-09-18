#include <SDL2/SDL.h>
#include <math.h>
#include <stdbool.h>

#define WINDOW_WIDTH 800
#define WINDOW_HEIGHT 600
#define GRID_SIZE 20

// Funktion, die das Vektorfeld definiert
void vector_field(float x, float y, float t, float *vx, float *vy) {
    // Beispiel: rotierendes Feld
    *vx = cos(t) * y;
    *vy = sin(t) * x;
}

// Funktion zum Zeichnen eines Pfeils
void draw_arrow(SDL_Renderer *renderer, float x, float y, float vx, float vy) {
    float len = sqrt(vx * vx + vy * vy);
    if (len == 0) return;

    float arrow_len = 10.0f;
    float angle = atan2(vy, vx);

    // Skalieren des Vektors
    vx = vx / len * arrow_len;
    vy = vy / len * arrow_len;

    // Linienkoordinaten
    SDL_RenderDrawLine(renderer, x, y, x + vx, y + vy);

    // Pfeilspitzen
    float arrow_angle = M_PI / 6; // 30 Grad
    float x1 = x + vx - arrow_len * cos(angle - arrow_angle);
    float y1 = y + vy - arrow_len * sin(angle - arrow_angle);
    SDL_RenderDrawLine(renderer, x + vx, y + vy, x1, y1);

    float x2 = x + vx - arrow_len * cos(angle + arrow_angle);
    float y2 = y + vy - arrow_len * sin(angle + arrow_angle);
    SDL_RenderDrawLine(renderer, x + vx, y + vy, x2, y2);
}

int main(int argc, char *argv[]) {
    SDL_Init(SDL_INIT_VIDEO);

    SDL_Window *window = SDL_CreateWindow("Vektorfeld-Plotter", SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED, WINDOW_WIDTH, WINDOW_HEIGHT, 0);
    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, 0);

    bool running = true;
    SDL_Event event;

    float t = 0.01f; // Zeitvariable für die Animation

    while (running) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT)
                running = false;
        }

        // Bildschirm löschen
        SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255); // Weißer Hintergrund
        SDL_RenderClear(renderer);

        // Vektorfeld zeichnen
        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255); // Schwarze Pfeile
        for (int i = 0; i <= WINDOW_WIDTH; i += GRID_SIZE) {
            for (int j = 0; j <= WINDOW_HEIGHT; j += GRID_SIZE) {
                float x = (float)i;
                float y = (float)j;
                float vx, vy;
                vector_field(x - WINDOW_WIDTH / 2, y - WINDOW_HEIGHT / 2, t, &vx, &vy);
                draw_arrow(renderer, x, y, vx, vy);
            }
        }

        SDL_RenderPresent(renderer);

        // Zeit aktualisieren
        t += 0.01f;

        SDL_Delay(16); // ~60 FPS
    }

    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
