using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RaycastReflection : MonoBehaviour {

    Vector3 _redirection;
    LineRenderer _lineRenderer;
    List<Vector3> _vertexPositions = new List<Vector3>();
    public float tolerance = 1;

    private void OnEnable()
    {
        _lineRenderer = GetComponent<LineRenderer>();
        _lineRenderer.positionCount++;
        _lineRenderer.SetPosition(0, transform.TransformDirection(transform.position + transform.forward));
        _lineRenderer.positionCount = 1;
    }

    void Update () {

        _vertexPositions.Clear();
        _vertexPositions.Add(transform.position);

        _redirection = transform.forward;

       // Debug.DrawRay(transform.position, _redirection, Color.red, 1);

        RaycastHit hit;
        for (int i = 0; i < _vertexPositions.Count; i++)
        {
            if (Physics.Raycast(_lineRenderer.GetPosition(i), _redirection, out hit, Mathf.Infinity))
            {
                _vertexPositions.Add(hit.point);
                
                _redirection = 2 * Vector3.Dot(transform.forward, Vector3.Normalize(hit.normal)) * Vector3.Normalize(hit.normal) - transform.forward;
                _redirection *= -1;

                Debug.Log(i);

                _lineRenderer.positionCount = _vertexPositions.Count;
                Vector3[] positions = new Vector3[_vertexPositions.Count];
                for (int j = 0; j < _vertexPositions.Count; j++)
                {
                    positions[j] = _vertexPositions[j];
                }
                _lineRenderer.SetPositions(positions);

                Debug.Log(_vertexPositions.Count);
            }
            //Debug.DrawRay(hit.point, _redirection, Color.blue, 1);
        }
        
        _lineRenderer.positionCount = _vertexPositions.Count;
        Vector3[] positions2 = new Vector3[_vertexPositions.Count];
        for (int j = 0; j < _vertexPositions.Count; j++)
        {
            positions2[j] = _vertexPositions[j];
        }
        _lineRenderer.SetPositions(positions2);
        /*if(_lineRenderer.positionCount >= 2)
            _lineRenderer.Simplify(tolerance);*/
       // Debug.Log(_lineRenderer.positionCount);

    }
}
