using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class AssignFaceColorByTag : MonoBehaviour {

    [SerializeField] Material _red;
    [SerializeField] Material _blue;
    [SerializeField] Material _green;
    [SerializeField] Material _purple;
    [SerializeField] Material _yellow;
    [SerializeField] Material _white;

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

            case "Purple":
                _meshRenderer.material = _purple;
                break;

            case "Yellow":
                _meshRenderer.material = _yellow;
                break;

            case "White":
                _meshRenderer.material = _white;
                break;
        }
	}
}
