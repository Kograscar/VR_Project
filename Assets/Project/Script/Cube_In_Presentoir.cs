using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class Cube_In_Presentoir : MonoBehaviour
{
    [SerializeField] private bool _cubeInSlot = false;
    [SerializeField] private GameObject _FauxCube;
    [SerializeField] private GameObject _Lock;
    [SerializeField] private int _NumSceneToLoad;
    [SerializeField] private int _NumSceneToUnload;
    [SerializeField] private int _NumSceneStart;
    [SerializeField] private string _ZoneForUnlock;
    [SerializeField] private Collider _Levier;

    private void Awake()
    {
        if (_NumSceneStart != 0)
        {
            SceneManager.LoadSceneAsync(_NumSceneStart, LoadSceneMode.Additive);
        }
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.name == _ZoneForUnlock && _cubeInSlot == false)
        {
            _cubeInSlot = true;
            Destroy(other.gameObject);
            _FauxCube.SetActive(true);
            Destroy(_Lock);

            StartCoroutine(WaitForUnload());

            if (_Levier != null)
            {
                _Levier.enabled = false;
            }
        }
    }

    private IEnumerator WaitForUnload()
    {
        SceneManager.LoadSceneAsync(_NumSceneToLoad, LoadSceneMode.Additive);
        yield return new WaitForSeconds(1f);
        SceneManager.UnloadSceneAsync(_NumSceneToUnload);
    }
}
