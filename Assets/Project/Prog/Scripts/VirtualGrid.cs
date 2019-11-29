using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VirtualGrid : Singleton<VirtualGrid> {

	public float size = .25f;
    public float lenght = 40f;

    [SerializeField] bool _showGrid = true;

    public Vector3 GetNearestPointOnGrid(Vector3 position)
    {
        position -= transform.position;

        int xCount = Mathf.RoundToInt(position.x / size);
        int yCount = Mathf.RoundToInt(position.y / size);
        int zCount = Mathf.RoundToInt(position.z / size);

        Vector3 result = new Vector3(
            xCount * size,
            yCount * size + .125f,
            zCount * size);

        result += transform.position;

        return result;
    }

    private void OnDrawGizmos()
    {
        if (_showGrid)
        {
            Gizmos.color = Color.yellow;
            for (float x = 0; x < lenght; x += size)
            {
                for (float z = 0; z < lenght; z += size)
                {
                    var point = GetNearestPointOnGrid(new Vector3(x, 0f, z) + transform.position);
                    Gizmos.DrawCube(point, new Vector3(size / 2, 0, size / 2));
                }
            }
        }
    }
}
