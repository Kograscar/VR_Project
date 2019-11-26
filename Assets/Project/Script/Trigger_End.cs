using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Trigger_End : MonoBehaviour {

    private void OnTriggerEnter(Collider other)
    {
        if(other.name == "Key(Clone)")
        {
            Debug.Log("NTM");
            Destroy(other.gameObject);
            Destroy(gameObject);
        }
    }
}
