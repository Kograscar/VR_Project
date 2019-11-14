using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class AssignFaceColorByTag : MonoBehaviour {

    [SerializeField] Material _red;
    [SerializeField] Material _blue;
    [SerializeField] Material _green;

    MeshRenderer _meshRenderer;

    void Start()
    {
        _meshRenderer = GetComponentInChildren<MeshRenderer>();
    }

    void Update () {
        switch (tag)
        {
            case "Red":
                _meshRenderer.material = _red;
                break;

            case "Blue":
                _meshRenderer.material = _blue;
                break;

            case "Green":
                _meshRenderer.material = _green;
                break;
        }
	}
}
