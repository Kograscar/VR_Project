using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class testSelection : MonoBehaviour {

    public int index = 0;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.tag == "AddBlue")
        {
            CubeInstanciater.Instance.enabled = true;
            CubeRemover.Instance.enabled = false;
            index = 1;
            Debug.Log("blue");
            Shader.SetGlobalFloat("Color_Select", 6);
        }

        if (other.gameObject.tag == "AddRed")
        {
            CubeInstanciater.Instance.enabled = true;
            CubeRemover.Instance.enabled = false;
            index = 2;
            Debug.Log("red");
            Shader.SetGlobalFloat("Color_Select", 2);
        }

        if (other.gameObject.tag == "AddGreen")
        {
            CubeInstanciater.Instance.enabled = true;
            CubeRemover.Instance.enabled = false;
            index = 3;
            Debug.Log("green");
            Shader.SetGlobalFloat("Color_Select", 1);
        }

        if (other.gameObject.tag == "AddWhite")
        {
            CubeInstanciater.Instance.enabled = true;
            CubeRemover.Instance.enabled = false;
            index = 4;
            Debug.Log("white");
            Shader.SetGlobalFloat("Color_Select", 9);
        }

        if (other.gameObject.tag == "AddRemove")
        {
            CubeInstanciater.Instance.enabled = false;
            CubeRemover.Instance.enabled = true;
            index = 5;
            Debug.Log("remove");
            Shader.SetGlobalFloat("Color_Select", 4);
        }
    }
}
