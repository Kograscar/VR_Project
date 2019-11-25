using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cube_In_Presentoir : MonoBehaviour {
    [SerializeField] private bool _cubeInSlot = false;
    [SerializeField] private GameObject _FauxCube;
    [SerializeField] private GameObject _Lock;

    private void OnTriggerEnter(Collider other)
    {
        if (other.name == "Zone_End(Clone)" && _cubeInSlot == false)
        {
            _cubeInSlot = true;
            Destroy(other.gameObject);
            _FauxCube.SetActive(true);
            Destroy(_Lock);
        }
    }
}
