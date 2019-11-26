using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class CubeSensor : MonoBehaviour {

    public readonly static string[] colors = new string[] { "Red", "Blue", "Green", "White", "Purple", "Yellow" };

    private void OnTriggerStay(Collider other)
    {
        bool hasTag = colors.Contains(other.tag);

        if (hasTag)
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
        bool hasTag = colors.Contains(other.tag);

        if (hasTag)
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

    private void LateUpdate()
    {
        CubeInstanciater.Instance._detectedObject = null;
        CubeRemover.Instance._detectedObject = null;
    }
}
