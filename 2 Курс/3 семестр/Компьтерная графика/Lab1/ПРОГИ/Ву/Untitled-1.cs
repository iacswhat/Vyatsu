void WuLine(int x0, int y0, int x1, int y1)
{
    var steep = Math.Abs(y1 - y0) > Math.Abs(x1 - x0);
    if (steep)
    {
        Swap(ref x0, ref y0);
        Swap(ref x1, ref y1);
    }
    if (x0 > x1)
    {
        Swap(ref x0, ref x1);
        Swap(ref y0, ref y1);
    }

    DrawPoint(steep, x0, y0, 1); // Эта функция автоматом меняет координаты местами в зависимости от переменной steep
    DrawPoint(steep, x1, y1, 1); // Последний аргумент — интенсивность в долях единицы
    float dx = x1 - x0;
    float dy = y1 - y0;
    float gradient = dy / dx;
    float y = y0 + gradient;
    for (var x = x0 + 1; x <= x1 - 1; x++)
    {
        DrawPoint(steep, x, (int)y, 1 - (y - (int)y));
        DrawPoint(steep, x, (int)y + 1, y - (int)y);
        y += gradient;
    }
}