using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Key_Manager : MonoBehaviour {

    [SerializeField] private GameObject _keyToInstantiate = null;
    [SerializeField] private Transform _offset = null;
    [SerializeField] private GameObject keyOfRoom;
    
    private void Start()
    {
        keyOfRoom = Instantiate(_keyToInstantiate, _offset.position, _offset.rotation);
    }
    void Update () {
        if(keyOfRoom == null)
        {

        }
		
	}
}
