using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Grid : MonoBehaviour {

	[SerializeField] private float gap = 1f;
    [SerializeField] private int size = 40;

    public Vector3 GetNearestPointOnGrid(Vector3 position)
    {
        //position -= transform.position;

        int xCount = Mathf.RoundToInt(position.x / gap);
        int yCount = Mathf.RoundToInt(position.y / gap);
        int zCount = Mathf.RoundToInt(position.z / gap);

        Vector3 result = new Vector3(
            xCount * gap,
            yCount * gap,
            zCount * gap);

        //result += transform.position;

        return result;
    }

    /*private void OnDrawGizmos()
    {
        Gizmos.color = Color.yellow;
        for (float x = 0; x < 40; x += gap)
        {
            for (float z = 0; z < 40; z += gap)
            {
                var point = GetNearestPointOnGrid(new Vector3(x, 0f, z));
                Gizmos.DrawSphere(point, 0.1f);
            }
        }
    }*/
}
