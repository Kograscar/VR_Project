using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RaycastReflection : MonoBehaviour {

    Vector3 _redirection;
    LineRenderer _lineRenderer;
    List<Vector3> _vertexPositions;

    private void OnEnable()
    {
        _lineRenderer = GetComponent<LineRenderer>();
        _lineRenderer.positionCount++;
        _lineRenderer.SetPosition(0, transform.TransformDirection(transform.position + transform.forward));
        _lineRenderer.positionCount = 0;
        _vertexPositions.Add(transform.position);
    }

    void Update () {

        _vertexPositions.Clear();
        _vertexPositions.Add(transform.position);

        _redirection = transform.TransformDirection(transform.position + transform.forward);

        Debug.DrawRay(transform.position, _redirection, Color.red, 1);

        RaycastHit hit;
        for (int i = 0; i < _lineRenderer.positionCount; i++)
        {
            if (Physics.Raycast(_lineRenderer.GetPosition(i), _redirection, out hit, Mathf.Infinity))
            {
                _vertexPositions.Add(hit.point);

                /*_lineRenderer.positionCount++;
                _lineRenderer.SetPosition(_lineRenderer.positionCount, hit.point);*/

                _lineRenderer.positionCount = _vertexPositions.Count;
                Vector3[] positions = new Vector3[_vertexPositions.Count];
                for (int j = 0; j < _vertexPositions.Count; j++)
                {
                    positions[j] = _vertexPositions[j];
                }
                _lineRenderer.SetPositions(positions);

                _redirection = 2 * Vector3.Dot(transform.forward, Vector3.Normalize(hit.normal)) * Vector3.Normalize(hit.normal) - transform.forward;

                _redirection *= -1;
            }
            Debug.DrawRay(hit.point, _redirection, Color.red, 1);
        }
        Debug.Log(_lineRenderer.positionCount);

    }
}
