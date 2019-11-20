using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Key_Manager : MonoBehaviour {

    [SerializeField] private GameObject _keyToInstantiate = null;
    [SerializeField] private Transform _offset = null;
    [SerializeField] private GameObject keyOfRoom = null;
    [SerializeField] private bool _coroutineOn = false;
    [SerializeField] private bool _coroutine2On = false;

    private void Start()
    {
        keyOfRoom = Instantiate(_keyToInstantiate, _offset.position, _offset.rotation,_offset);
    }

    void Update ()
    {

        if (keyOfRoom.activeInHierarchy == false  && _coroutineOn == false)
        {
            StartCoroutine(WaitforInstantiateKey());
        }

        if (keyOfRoom.transform.position != _offset.position && _coroutine2On == false)
        {
            StartCoroutine(WaitforDesable());
        }
		
	}
    private IEnumerator WaitforInstantiateKey()
    {
        _coroutineOn = true;
        yield return new WaitForSeconds(1f);

        keyOfRoom.transform.position = _offset.position;
        keyOfRoom.SetActive(true);
        _coroutineOn = false;
    }

    private IEnumerator WaitforDesable()
    {
        _coroutine2On = true;
        yield return new WaitForSeconds(5f);
        keyOfRoom.SetActive(false);
        _coroutine2On = false;
    }

}
