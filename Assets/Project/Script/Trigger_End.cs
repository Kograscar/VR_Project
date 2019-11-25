using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Trigger_End : MonoBehaviour {

    private void OnTriggerEnter(Collider other)
    {
        if(other.name == "Trigger_End")
        {
            Destroy(other.gameObject);

        }
    }
}
