#include <SDL2/SDL.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>

#define WINDOW_WIDTH 640
#define WINDOW_HEIGHT 480
#define BLOCK_SIZE 20
#define INITIAL_SNAKE_LENGTH 5

typedef struct {
    int x, y;
} Point;

typedef struct {
    Point *body;
    int length;
    int capacity;
    int dx, dy;
} Snake;

void add_segment(Snake *snake) {
    if (snake->length >= snake->capacity) {
        snake->capacity *= 2;
        snake->body = realloc(snake->body, snake->capacity * sizeof(Point));
    }
    snake->body[snake->length] = snake->body[snake->length - 1];
    snake->length++;
}

void move_snake(Snake *snake) {
    for (int i = snake->length - 1; i > 0; i--) {
        snake->body[i] = snake->body[i - 1];
    }
    snake->body[0].x += snake->dx;
    snake->body[0].y += snake->dy;
}

bool check_collision(Snake *snake) {
    Point head = snake->body[0];
    if (head.x < 0 || head.x >= WINDOW_WIDTH / BLOCK_SIZE ||
        head.y < 0 || head.y >= WINDOW_HEIGHT / BLOCK_SIZE)
        return true;
    for (int i = 1; i < snake->length; i++) {
        if (head.x == snake->body[i].x && head.y == snake->body[i].y)
            return true;
    }
    return false;
}

void spawn_food(Point *food, Snake *snake) {
    bool on_snake;
    do {
        on_snake = false;
        food->x = rand() % (WINDOW_WIDTH / BLOCK_SIZE);
        food->y = rand() % (WINDOW_HEIGHT / BLOCK_SIZE);
        for (int i = 0; i < snake->length; i++) {
            if (food->x == snake->body[i].x && food->y == snake->body[i].y) {
                on_snake = true;
                break;
            }
        }
    } while (on_snake);
}

int main(int argc, char *argv[]) {
    SDL_Init(SDL_INIT_VIDEO);
    srand(time(NULL));

    SDL_Window *window = SDL_CreateWindow("Snake", SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED, WINDOW_WIDTH, WINDOW_HEIGHT, 0);
    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, 0);

    Snake snake;
    snake.length = INITIAL_SNAKE_LENGTH;
    snake.capacity = 100;
    snake.body = malloc(snake.capacity * sizeof(Point));
    snake.dx = 1;
    snake.dy = 0;
    for (int i = 0; i < snake.length; i++) {
        snake.body[i].x = (WINDOW_WIDTH / BLOCK_SIZE) / 2 - i;
        snake.body[i].y = (WINDOW_HEIGHT / BLOCK_SIZE) / 2;
    }

    Point food;
    spawn_food(&food, &snake);

    bool running = true;
    SDL_Event event;
    Uint32 last_move = SDL_GetTicks();

    while (running) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT)
                running = false;
            else if (event.type == SDL_KEYDOWN) {
                switch (event.key.keysym.sym) {
                    case SDLK_UP:
                        if (snake.dy == 0) { snake.dx = 0; snake.dy = -1; }
                        break;
                    case SDLK_DOWN:
                        if (snake.dy == 0) { snake.dx = 0; snake.dy = 1; }
                        break;
                    case SDLK_LEFT:
                        if (snake.dx == 0) { snake.dx = -1; snake.dy = 0; }
                        break;
                    case SDLK_RIGHT:
                        if (snake.dx == 0) { snake.dx = 1; snake.dy = 0; }
                        break;
                }
            }
        }

        Uint32 current_time = SDL_GetTicks();
        if (current_time - last_move > 100) {
            move_snake(&snake);
            if (check_collision(&snake)) {
                running = false;
                break;
            }
            if (snake.body[0].x == food.x && snake.body[0].y == food.y) {
                add_segment(&snake);
                spawn_food(&food, &snake);
            }
            last_move = current_time;
        }

        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
        SDL_RenderClear(renderer);

        // Zeichne Essen
        SDL_Rect food_rect = { food.x * BLOCK_SIZE, food.y * BLOCK_SIZE,
                               BLOCK_SIZE, BLOCK_SIZE };
        SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
        SDL_RenderFillRect(renderer, &food_rect);

        // Zeichne Schlange
        SDL_SetRenderDrawColor(renderer, 0, 255, 0, 255);
        for (int i = 0; i < snake.length; i++) {
            SDL_Rect rect = { snake.body[i].x * BLOCK_SIZE,
                              snake.body[i].y * BLOCK_SIZE,
                              BLOCK_SIZE, BLOCK_SIZE };
            SDL_RenderFillRect(renderer, &rect);
        }

        SDL_RenderPresent(renderer);
        SDL_Delay(10);
    }

    free(snake.body);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
