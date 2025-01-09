
#include <stdio.h>
float objetosc(float a, float b, float c, float grubosc, float marg);
int main()
{
	float W, H, D, grubosc, M, v;

	printf("Podaj szerokosc: ");
	scanf_s("%f", &W);

	printf("Podaj wysokosc: ");
	scanf_s("%f", &H);

	printf("Podaj dlugosc: ");
	scanf_s("%f", &D);

	printf("Podaj grubosc szkla: ");
	scanf_s("%f", &grubosc);

	printf("Podaj margines: ");
	scanf_s("%f", &M);

	v = objetosc(W, H, D, grubosc, M);
	printf("Objetosc wynosi: %f\n", v);

}