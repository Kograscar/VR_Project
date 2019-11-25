using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Zone_End : MonoBehaviour {

    [SerializeField] private GameObject _VFX_Pick;
   

    void Update () {
        _VFX_Pick.SetActive(true);
        transform.Rotate(0, 1, 0);
    }
}
