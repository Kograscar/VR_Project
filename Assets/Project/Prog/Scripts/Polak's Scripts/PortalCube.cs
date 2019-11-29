using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PortalCube : MonoBehaviour {

    [SerializeField] private Transform _targetPosition;
    

    private void OnTriggerEnter(Collider other)
    {
         if(other.gameObject.tag == ("MainCube") )
         {
            other.transform.position = _targetPosition.position;
         }
    }

    
}
