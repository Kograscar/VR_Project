using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeSensor : MonoBehaviour {

    private void OnTriggerStay(Collider other)
    {
        if (other.CompareTag("Red") || other.CompareTag("Blue") || other.CompareTag("Green") || other.CompareTag("White") || other.CompareTag("Purple") || other.CompareTag("Yellow"))
        {
            if (CubeInstanciater.Instance.enabled)
            {
                CubeInstanciater.Instance._detectedObject = other.gameObject;
            }
            else
            {
                CubeRemover.Instance._detectedObject = other.gameObject;
            }
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Red") || other.CompareTag("Blue") || other.CompareTag("Green") || other.CompareTag("White") || other.CompareTag("Purple") || other.CompareTag("Yellow"))
        {
            if (CubeInstanciater.Instance.enabled)
            {
                CubeInstanciater.Instance._detectedObject = null;
            }
            else
            {
                CubeRemover.Instance._detectedObject = null;
            }
        }
    }
}
