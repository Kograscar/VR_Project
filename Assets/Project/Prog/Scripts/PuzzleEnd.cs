using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PuzzleEnd : MonoBehaviour {

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("MainCube"))
        {

        }
    }
}
