attribute highp vec2 myVertex;
void main()
{
    gl_Position = vec4(myVertex, 1.0, 1.0);
    gl_PointSize = 1.0;
}