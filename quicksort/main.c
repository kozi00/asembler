#include <stdio.h>

void quicksort(int* array, int low, int high);

int main() {
	printf_s("Podaj liczbe elementow tablicy: ");
	int length = scanf_s("%d", &length);

	int* array = (int*)malloc(length * sizeof(int));

	for (int i = 0; i < length; i++) {
		printf_s("Podaj %d element tablicy: ", i + 1);
		scanf_s("%d", &array[i]);
	}

	quicksort(array, 0, length - 1);

	printf_s("Posortowana tablica: ");
	for (int i = 0; i < length; i++) {
		printf("%d ", array[i]);
	}
	printf("\n");
	return 0;
}